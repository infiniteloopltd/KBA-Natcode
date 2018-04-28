import Foundation

class Logging
{
    static var Key = Secret.remoteLogCatKey
    
    static func Log(Channel : String, Log : String, Completion: ((Bool) -> ())? = nil)
    {
        let strChannel = Channel.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed)!
        let strLog = Log.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed)!
        print("\(Channel):\(Log)")
        let url = URL(string: "http://www.remotelogcat.com/log.php?apikey=\(Key)&channel=\(strChannel)&log=\(strLog)")
        let task = URLSession.shared.dataTask(with: url!) {(data, response, error) in
            Completion?(error == nil)
        }
        task.resume()
    }
}
