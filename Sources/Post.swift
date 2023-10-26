struct Post:CustomStringConvertible {
    var id: Int
    var author: String
    var likes: Int
    var shares: Int
    var dateTime: String
    var content: String

    init(_ id: Int, _ author: String,  _ likes: Int, _ shares: Int, _ dateTime: String, _ content: String) {
        self.id = id
        self.author = author
        self.likes = likes
        self.shares = shares
        self.dateTime = dateTime
        self.content = content
    }

    var description: String {
        return "\(id),\(author),\(likes),\(shares),\(dateTime),\(content)"
    }
}
