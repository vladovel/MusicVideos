//
//  MusicVideo.swift
//  MusicVideos
//
//  Created by Vlado Velkovski on 4/18/16.
//  Copyright © 2016 Vlado Velkovski. All rights reserved.
//

import Foundation

class Videos {
    
    private var _vName: String
    private var _vImageUrl: String
    private var _vVideoUrl: String
    private var _vRights: String
    private var _vPrice: String
    private var _vArtist: String
    private var _vGenre: String
    private var _vLinkToiTunes: String
    private var _vReleaseDte: String
    private var _vImid: String
    
    var vImageData: NSData?
    
    var vName: String {
        return _vName
    }
    
    var vImageUrl: String {
        return _vImageUrl
    }
    
    var vVideoUrl: String {
        return _vVideoUrl
    }
    
    var vRights: String {
        return _vRights
    }
    
    var vPrice: String {
        return _vPrice
    }
    
    var vArtist: String {
        return _vArtist
    }
    
    var vGenre: String {
        return _vGenre
    }
    
    var vLinkToiTunes: String {
        return _vLinkToiTunes
    }
    
    var vReleaseDte: String {
        return _vReleaseDte
    }
    
    var vImid: String {
        return _vImid
    }
    
    init(data: JSONDictionary) {
    
        if let name = data["im:name"] as? JSONDictionary, vName = name["label"] as? String {
            self._vName = vName
        } else {
            self._vName = ""
        }
        
        
        if let img = data["im:image"] as? JSONArray, image = img[2] as? JSONDictionary, immage = image["label"] as? String  {
            self._vImageUrl = immage.stringByReplacingOccurrencesOfString("100x100", withString: "600x600")
        } else {
            self._vImageUrl = ""
        }
        
        
        if let video = data["link"] as? JSONArray, vUrl = video[1] as? JSONDictionary, vHref = vUrl["attributes"] as? JSONDictionary, vVideoUrl = vHref["href"] as? String {
            self._vVideoUrl = vVideoUrl
        } else {
            self._vVideoUrl = ""
        }
        
        
        if let rights = data["rights"] as? JSONDictionary, vRights = rights["label"] as? String {
            self._vRights = vRights
        } else {
            self._vRights = ""
        }
        
        
        if let price = data["im:price"] as? JSONDictionary, vPrice = price["label"] as? String {
            self._vPrice = vPrice
        } else {
            self._vPrice = ""
        }
        
        
        if let artist = data["im:artist"] as? JSONDictionary, vArtist = artist["label"] as? String {
            self._vArtist = vArtist
        } else {
            self._vArtist = ""
        }
        
        
        if let genre = data["category"] as? JSONDictionary, attr = genre["attributes"] as? JSONDictionary, vGenre = attr["term"] as? String {
            self._vGenre = vGenre
        } else {
            self._vGenre = ""
        }
        
        
        if let link = data["id"] as? JSONDictionary, vLinkToiTunes = link["label"] as? String {
            self._vLinkToiTunes = vLinkToiTunes
        } else {
            self._vLinkToiTunes = ""
        }
        
        
        if let release = data["im:releaseDate"] as? JSONDictionary, attr = release["attributes"] as? JSONDictionary, vReleaseDte = attr["label"] as? String {
            self._vReleaseDte = vReleaseDte
        } else {
            self._vReleaseDte = ""
        }
        
        
        if let imid = data["id"] as? JSONDictionary, attr = imid["attributes"] as? JSONDictionary, vImid = attr["im:id"] as? String {
            self._vImid = vImid
        } else {
            self._vImid = ""
        }
    }
    
    
    
}
