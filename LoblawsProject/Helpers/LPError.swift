//
//  LPError.swift
//  LoblawsProject
//
//  Created by Bill Zhao on 2021-02-07.
//

import Foundation

enum LPError: String, Error {
    case URLError = "Invalid URL."
    case clientError = "Unable to complete your request due to a client error. Please check your internet connection and try again."
    case serverError = "Invalid response from the server."
    case dataError = "Invalid data recieved from the server. Please try again."
    case decodeError = "The JSON data could not be decoded correctly for its model type."
    case fileWriteError = "Encountered error while writing data to the file. Please try again."
}
