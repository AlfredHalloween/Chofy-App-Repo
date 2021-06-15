//
//  RequestExtensionEntities.swift
//  ChofyExtensions
//
//  Created by Juan Alfredo García González on 14/06/21.
//

import Foundation

public enum ErrorResponseType: String {
    case accepted = "ACCEPTED"
    case alreadyReported = "ALREADY_REPORTED"
    case badGateway = "BAD_GATEWAY"
    case badRequest = "BAD_REQUEST"
    case bandwidthLimitExceeded = "BANDWIDTH_LIMIT_EXCEEDED"
    case checkpoint = "CHECKPOINT"
    case conflict = "CONFLICT"
    case continueStatus = "CONTINUE"
    case created = "CREATED"
    case expectationFailed = "EXPECTATION_FAILED"
    case failedDependency = "FAILED_DEPENDENCY"
    case forbidden = "FORBIDDEN"
    case found = "FOUND"
    case gatewayTimeout = "GATEWAY_TIMEOUT"
    case gone = "GONE"
    case httpVersionNotSupported = "HTTP_VERSION_NOT_SUPPORTED"
    case iAmATeapot = "I_AM_A_TEAPOT"
    case imUsed = "IM_USED"
    case insufficientStorage = "INSUFFICIENT_STORAGE"
    case internalServerError = "INTERNAL_SERVER_ERROR"
    case lengthRequired = "LENGTH_REQUIRED"
    case locked = "LOCKED"
    case loopDetected = "LOOP_DETECTED"
    case methodNotAllowed = "METHOD_NOT_ALLOWED"
    case movedPermanently = "MOVED_PERMANENTLY"
    case multiStatus = "MULTI_STATUS"
    case multipleChoices = "MULTIPLE_CHOICES"
    case networkAuthenticationRequired = "NETWORK_AUTHENTICATION_REQUIRED"
    case noContent = "NO_CONTENT"
    case nonAuthoritativeInformation = "NON_AUTHORITATIVE_INFORMATION"
    case notAcceptable = "NOT_ACCEPTABLE"
    case notExtended = "NOT_EXTENDED"
    case notFound = "NOT_FOUND"
    case notImplemented = "NOT_IMPLEMENTED"
    case notModified = "NOT_MODIFIED"
    case ok = "OK"
    case partialContent = "PARTIAL_CONTENT"
    case payloadTooLarge = "PAYLOAD_TOO_LARGE"
    case paymentRequired = "PAYMENT_REQUIRED"
    case permanentRedirect = "PERMANENT_REDIRECT"
    case preconditionFailed = "PRECONDITION_FAILED"
    case preconditionRequired = "PRECONDITION_REQUIRED"
    case processing = "PROCESSING"
    case proxyAuthenticationRequired = "PROXY_AUTHENTICATION_REQUIRED"
    case requestHeaderFieldsTooLarge = "REQUEST_HEADER_FIELDS_TOO_LARGE"
    case requestTimeout = "REQUEST_TIMEOUT"
    case requestedRangeNotSatisfiable = "REQUEST_RANGE_NOT_SATISFIABLE"
    case resetContent = "RESET_CONTENT"
    case seeOther = "SEE_OTHER"
    case serviceUnavailable = "SERVICE_UNAVAILABLE"
    case switchingProtocols = "SWITCHING_PROTOCOLS"
    case temporaryRedirect = "TEMPORARY_REDIRECT"
    case tooEarly = "TOO_EARLY"
    case tooManyRequests = "TOO_MANY_REQUESTS"
    case unauthorized = "UNAUTHORIZED"
    case unavailableForLegalReasons = "UNAVAILABLE_FOR_LEGAL_REASONS"
    case unprocessableEntity = "UNPROCESSABLE_ENTITY"
    case unsupportedMediaType = "UNSUPPORTED_MEDIA_TYPE"
    case upgradeRequired = "UPGRADE_REQUIRED"
    case uriTooLong = "URI_TOO_LONG"
    case variantAlsoNegotiates = "VARIANT_ALSO_NEGOTIATES"
}

enum RequestError: Error {
    case noResponse
    case errorParsing
    
    case unexpected(code: Int)
}

extension RequestError {
    var isFatal: Bool {
        if case RequestError.unexpected = self { return true }
        else { return false }
    }
}

extension RequestError: CustomStringConvertible {
    public var description: String {
        switch self {
        case .noResponse:
            return "El servicio no responde."
        case .errorParsing:
            return "El parseo es incorrecto."
        case .unexpected(_):
            return "Un error inesperado ocurrió."
        }
    }
}

public struct ErrorResponse: Codable, LocalizedError {
    public var message: String?
    var status: String?
    public var timestamp: String?
    public var statusCode: ErrorResponseType {
        return ErrorResponseType(rawValue: status ?? "") ?? .notImplemented
    }
    
    public var errorDescription: String? {
        return message
    }
}
