import Foundation

class SocialMediaAnalyser {
    var records: Records

    init(filename: String) {
        UI.heading(title: "Program Initialisation")
        let projectRootURL = URL(fileURLWithPath: #file).deletingLastPathComponent().deletingLastPathComponent()
        self.records = Records()
        do {
            print("Reading \(filename) file ...")
            try self.records.loadPosts(path: projectRootURL.appendingPathComponent(filename))
        } catch {
            print("File is not found!")
        }
    }

    func run() {
        var selectedOption: Int
        repeat {
            // print menu
            UI.heading(title: "Select from main menu")
            UI.menu(options: [
                (1, "Add a social media post"),
                (2, "Delete an exisiting social media post"),
                (3, "Retrieve a social meida post"),
                (4, "Retrieve the top N posts with most likes"),
                (5, "Retrieve the top N posts with most shares"),
                (6, "Exit")
            ], prompt: "Please select: ")

            // get user's input
            do {
                selectedOption = try Parser.parseInt(str: readLine(), min: 0)
            } catch { selectedOption = -1 }

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
        do {
            print("ID: ", terminator: "")
            let id = try Parser.parseInt(str: readLine(), min: 0)
            print("Content: ", terminator: "")
            let content = try Parser.parseStr(str: readLine())
            print("Author: ", terminator: "")
            let author = try Parser.parseStr(str: readLine())
            print("Likes: ", terminator: "")
            let likes = try Parser.parseInt(str: readLine(), min: 0)
            print("Shares: ", terminator: "")
            let shares = try Parser.parseInt(str: readLine(), min: 0)
            print("Date/Time: ", terminator: "")
            let dateTime = try Parser.parseDateTime(str: readLine(), format: "dd/MM/yyyy HH:mm")
            // create Post object
            let post = Post(id: id, author: author, likes: likes, shares: shares, dateTime: dateTime, content: content)

            // add Post obj to records
            records.addPost(post: post)
        } catch ParseValueError.withMessage(let message) {
            print(message)
        } catch {
            print("Something wrong happend")
        }
    }

    func deletePost() {
        let id = Int(readLine()!)!
        records.deletePostById(id: id)
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
