import App
import Vapor

var env = try Environment.detect()
try LoggingSystem.bootstrap(from: &env)
let app = Application(env)
app.http.server.configuration.port = 8090
defer { app.shutdown() }
try Configuration(app).perform()
try app.run()
