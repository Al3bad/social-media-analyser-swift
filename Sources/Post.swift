struct Post:CustomStringConvertible {
    var id: Int
    var author: String
    var likes: Int
    var shares: Int
    var dateTime: String
    var content: String

    init(id: Int, author: String, likes: Int, shares: Int, dateTime: String, content: String) {
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
