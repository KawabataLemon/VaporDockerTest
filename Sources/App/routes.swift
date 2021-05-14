import Vapor

func routes(_ app: Application) throws {
    app.get { req in
        return "It works!"
    }

    app.get("hello") { req -> String in
        return "Hello, world!"
    }
    
    let apis = app.grouped("api")
    
    apis.get("stores") { req -> String in
        
        return "キャッシュレスはSTORES決済！"
    }
}
