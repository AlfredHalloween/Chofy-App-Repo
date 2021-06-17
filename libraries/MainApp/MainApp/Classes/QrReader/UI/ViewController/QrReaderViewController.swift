//
//  QrReaderViewController.swift
//  MainApp
//
//  Created by Juan Alfredo García González on 20/04/21.
//

import UIKit
import AVFoundation
import RxSwift
import RxCocoa
import ChofyExtensions
import ChofyStyleGuide

protocol QrReaderViewOutput {
    var permissionsStatusGranted: Observable<Bool> { get }
    
    func didLoad()
    func requestPermissions()
    func dismissQr()
    func qrNotWorking()
    func sendCode(_ code: String)
}

final class QrReaderViewController: UIViewController {
    
    // MARK: Properties
    private let disposeBag: DisposeBag = DisposeBag()
    private let presenter: QrReaderViewOutput
    private var captureSession: AVCaptureSession = AVCaptureSession()
    private var previewLayer: ScannerOverlayPreviewLayer?
    private var metadataOutput: AVCaptureMetadataOutput?
    
    // MARK: Outlets
    @IBOutlet private weak var qrViewContainer: UIView!
    @IBOutlet private weak var qrTitle: UILabel! {
        didSet {
            qrTitle.text = "Lector de barras"
            qrTitle.font = ChofyFontCatalog.headlineBold
        }
    }
    @IBOutlet private weak var qrSubtitle: UILabel! {
        didSet {
            qrSubtitle.text = "Registra o busca el producto mediante el lector de código de barras."
            qrSubtitle.numberOfLines = 2
            qrSubtitle.textAlignment = .center
            qrSubtitle.font = ChofyFontCatalog.bodyBold
        }
    }
    @IBOutlet private weak var btnCloseQr: UIButton! {
        didSet {
            let image = ChofyIcons.close.withRenderingMode(.alwaysTemplate)
            btnCloseQr.setImage(image, for: .normal)
            btnCloseQr.setTitleColor(ChofyColors.text, for: .normal)
            btnCloseQr.tintColor = ChofyColors.text
        }
    }
    
    init(with presenter: QrReaderViewOutput) {
        let identifier = String(describing: QrReaderViewController.self)
        self.presenter = presenter
        super.init(nibName: identifier, bundle: MainBundle.bundle)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been found")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        presenter.didLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        if !(captureSession.isRunning) {
            captureSession.startRunning()
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        if (captureSession.isRunning) {
            captureSession.stopRunning()
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
    
    override var prefersStatusBarHidden: Bool {
        return true
    }
    
    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        return .portrait
    }
}

extension QrReaderViewController: AVCaptureMetadataOutputObjectsDelegate {
    func metadataOutput(_ output: AVCaptureMetadataOutput,
                        didOutput metadataObjects: [AVMetadataObject],
                        from connection: AVCaptureConnection) {
        captureSession.stopRunning()
        
        if let metadataObject = metadataObjects.first {
            guard let readableObject = metadataObject as? AVMetadataMachineReadableCodeObject,
                  let stringValue = readableObject.stringValue else {
                return
            }
            AudioServicesPlaySystemSound(SystemSoundID(kSystemSoundID_Vibrate))
            presenter.sendCode(stringValue)
        }
    }
}

private extension QrReaderViewController {
    
    func setup() {
        setViewBackground(color: ChofyColors.screenBackground)
        setupCloseBtnRx()
        presenter.permissionsStatusGranted
            .subscribe(onNext: { [weak self] granted in
                guard let self = self else { return }
                granted ? self.setupCamera() : self.presenter.requestPermissions()
            }).disposed(by: disposeBag)
    }
    
    func setupCamera() {
        metadataOutput = AVCaptureMetadataOutput()
        setupCaptureSession()
        setupPreviewLayer()
    }
    
    func setupCloseBtnRx() {
        btnCloseQr.rx.tap
            .throttle(RxTimeInterval.milliseconds(350), scheduler: MainScheduler.instance)
            .subscribe(onNext: { [weak self] in
                guard let self = self else {
                    return
                }
                self.presenter.dismissQr()
            }).disposed(by: disposeBag)
    }
    
    func setupCaptureSession() {
        guard let videoCaptureDevice = AVCaptureDevice.default(for: .video),
              let videoInput: AVCaptureDeviceInput = try? AVCaptureDeviceInput(device: videoCaptureDevice),
              let metadataOutput = metadataOutput,
              captureSession.canAddInput(videoInput),
              captureSession.canAddOutput(metadataOutput) else {
            captureSessionFailed()
            return
        }
        captureSession.addInput(videoInput)
        captureSession.addOutput(metadataOutput)
        metadataOutput.setMetadataObjectsDelegate(self, queue: DispatchQueue.main)
        metadataOutput.metadataObjectTypes = [.ean8, .ean13, .pdf417]
    }
    
    func setupPreviewLayer() {
        let heightQrReader: CGFloat = qrViewContainer.layer.frame.height * 0.6
        let widthQrReader: CGFloat = heightQrReader * 0.5
        previewLayer = ScannerOverlayPreviewLayer(session: captureSession)
        previewLayer?.backgroundColor = UIColor.black.withAlphaComponent(0.35).cgColor
        previewLayer?.lineColor = UIColor.white
        previewLayer?.frame = qrViewContainer.layer.bounds
        previewLayer?.videoGravity = .resizeAspectFill
        previewLayer?.maskSize = CGSize(width: widthQrReader, height: heightQrReader)
        metadataOutput?.rectOfInterest = previewLayer?.rectOfInterest ?? .zero
        qrViewContainer.layer.addSublayer(previewLayer ?? CALayer())
        captureSession.startRunning()
    }
    
    func captureSessionFailed() {
        presenter.qrNotWorking()
    }
}
