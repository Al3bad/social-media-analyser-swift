import Foundation

class Records {
    var posts: [Post];

    init () {
        self.posts = []
    }

    func loadPosts(path: URL) throws {
        var validPostsCount = 0
        var invalidPostsCount = 0
        let content = try String(contentsOf: path, encoding: .utf8).trimmingCharacters(in: .whitespacesAndNewlines)
        for line in content.components(separatedBy: "\n") {
            do {
                let fields = try Parser.parseCSV(str: line, expectedFields: 6)
                let id = try Parser.parseInt(str: fields[0], min: 0)
                let content = try Parser.parseStr(str: fields[1])
                let author = try Parser.parseStr(str: fields[2])
                let likes = try Parser.parseInt(str: fields[3], min: 0)
                let shares = try Parser.parseInt(str: fields[4], min: 0)
                let dateTime = try Parser.parseDateTime(str: fields[5], format: "dd/MM/yyyy HH:mm")
                posts.append(Post(id: id, author: author, likes: likes, shares: shares, dateTime: dateTime, content: content))
                validPostsCount += 1
            } catch ParseValueError.withMessage {
                invalidPostsCount += 1
            }
        }
        print("\(validPostsCount) valid posts has been loaded")
        print("\(invalidPostsCount) invalid posts has been ignored")
    }

    func addPost(post: Post) -> Post? {
        if let _ = posts.first(where: {$0.id == post.id}) {
            return nil
        }
        posts.append(post)
        return post
    }

    func deletePostById(id: Int) {
        if let idx = posts.firstIndex(where: {$0.id == id}) {
            posts.remove(at: idx)
        }
    }

    func retrievePostById(id: Int) -> Post? {
        guard let post = posts.first(where: {$0.id == id}) else {
            return nil
        }
        return post
    }

    func retrieveMostLikedPosts(limit: Int) -> [Post] {
        posts.sort(by: {$0.likes > $1.likes})
        return posts
    }

    func retrieveMostSharedPosts(limit: Int) -> [Post] {
        posts.sort(by: {$0.shares > $1.shares})
        return posts
    }
}
