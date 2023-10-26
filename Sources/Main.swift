@main
struct Main {
    static func main() {
        let app = SocialMediaAnalyser(filename: "posts.csv")
        app.run()
    }
}
