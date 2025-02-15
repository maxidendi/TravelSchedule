import Foundation
import OpenAPIRuntime

enum ErrorType: String, Error {
    case serverError = "Ошибка сервера"
    case noInternet = "Нет интернета"
    case badRequest = "Неверный запрос"
}
