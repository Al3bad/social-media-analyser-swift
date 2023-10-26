class SocialMediaAnalyser {
    var records: Records

    init(filename: String) {
        // Init
        self.records = Records()
        self.records.loadPosts(filename: filename)
    }

    func run() {

        // Display menu
        let title = "Select from main menu:"
        let options: [Int: String] = [
            1: "Add a social media post",
            2: "Delete an exisiting social media post",
            3: "Retrieve a social meida post",
            4: "Retrieve the top N posts with most likes",
            5: "Retrieve the top N posts with most shares",
            6: "Exit"
        ]

        var selectedOption: Int

        repeat {
            // print menu
            print(title)
            for (key, value) in options {
                print("\(key)) \(value)")
            }

            // TODO: get user's input
            selectedOption = Int(readLine()!)!

            // run funciton handler
            switch selectedOption {
            case 1:
                addPost()
            case 2:
                deletePost()
            case 3:
                retrievePost()
            case 4:
                retrieveMostLikedPost()
            case 5:
                retrieveMostSharedPost()
            case 6:
                print("Exist")
            default:
                print("Invalid option")
            }
        } while selectedOption != 6;
    }

    func addPost() {
        // take user input
        let id = Int(readLine()!)!
        let author = readLine()!
        let likes = Int(readLine()!)!
        let shares = Int(readLine()!)!
        let content = readLine()!
        let dateTime = readLine()!

        // create Post object
        let post = Post(id, author, likes, shares, dateTime, content)

        // add Post obj to records
        records.addPost(post: post);
    }

    func deletePost() {
        let id = Int(readLine()!)!
        records.deletePostById(id: id)
        print("Done")
    }

    func retrievePost() {
        let id = Int(readLine()!)!
        if let post = records.retrievePostById(id: id) {
            print(post)
        }
    }

    func retrieveMostLikedPost() {
        let limit = Int(readLine()!)!
        for post in records.retrieveMostLikedPosts(limit: limit) {
            print(post)
        }
    }

    func retrieveMostSharedPost() {
        let limit = Int(readLine()!)!
        for post in records.retrieveMostSharedPosts(limit: limit) {
            print(post)
        }
    }
}
