struct PassengerPayload: Decodable {
    let passengers: [Passenger]
    let next: Int?
}
