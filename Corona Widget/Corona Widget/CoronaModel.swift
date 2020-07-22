
//CoronaModel.swift
//Corona Widget

Created by Aaryan Kothari on 22/07/20.


import Foundation



struct Corona : Codable {
    let Global : Global
    let Countries : Countries
}

struct Global : Codable {
    let NewConfirmed  : Double
    let TotalConfirmed  : Double
    let NewDeaths  : Double
    let TotalDeaths  : Double
    let NewRecovered  : Double
    let TotalRecovered  : Double
}

struct Countries : Codable{
    let Country : String
    let CountryCode : String
    let Slug : String
    let NewConfirmed : Double
    let TotalConfirmed : Double
    let NewDeaths : Double
    let TotalDeaths : Double
    let NewRecovered : Double
    let TotalRecovered : Double
    let Date : String
}
