//
//  QueryError.swift
//  apollo-fetcherPackageDescription
//
//  Created by Evgeny Kalashnikov on 27.03.2018.
//

public enum QueryError: Error {
    case unnown
    case another(error: Error)
}
