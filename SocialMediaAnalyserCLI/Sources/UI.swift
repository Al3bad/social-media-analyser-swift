class UI {
    static func heading(title: String) {
        let width = 50
        print()
        print(String(repeating: "-", count: width))
        print("> \(title)")
        print(String(repeating: "-", count: width))
    }

    static func menu(options: [(Int, String)], prompt: String) {
        for (key, value) in options {
            print("\(key)) \(value)")
        }
        print(prompt, terminator: "")
    }
}
