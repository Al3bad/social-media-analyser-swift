class Records {
    var posts: [Post];

    init () {
        self.posts = []
    }

    func loadPosts(filename: String) {
        print("TODO: load posts ..")
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
