extension Set where Element == String {
    
    func getMatch(for text: String) -> String? {
        
        let matches = self.filter({
            
            if let range = $0.range(of: text), range.lowerBound.encodedOffset == 0 {
                return true
            }
            
            return false
        })
        
        return matches.first
    }
}
