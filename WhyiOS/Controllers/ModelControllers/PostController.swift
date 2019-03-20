//
//  PostController.swift
//  WhyiOS
//
//  Created by Brooke Kumpunen on 3/20/19.
//  Copyright © 2019 Rund LLC. All rights reserved.
//

import Foundation

class PostController {
    
    //In this file, I need:
    
    //Singleton
    static let shared = PostController()
    
    //Source of truth?
    var posts: [Post] = []
    
    //BaseUrl
    let baseUrl = URL(string: "https://whydidyouchooseios.firebaseio.com/reasons")
    
    //CRUD! Well, only read and create
    
    //Read:
    func fetchPosts(completion: @escaping() -> Void) {
        //First I need to create a URL request. To do this, I must:
        //Unwrap the url
        guard var url = baseUrl else {completion(); return}
        //Now add json to it, and create a request.
        url.appendPathExtension("json")
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.httpBody = nil
        //Okay, I have a request. Let's do something with it.
        URLSession.shared.dataTask(with: request) { (data, _, error) in
            if let error = error {
                print("\(error.localizedDescription) \(error) in function: \(#function)")
                completion()
                return
            }
            //After I handle the error, let's unwrap the data we may or may not have.
            guard let data = data else {completion(); return}
            //If the code has gotten to this point, there is data here. let's decode it and put it into the correct display format. I.E. a dictionary. This always requires a do block.
            do {
                let postsDictionary = try JSONDecoder().decode([String: Post].self, from: data)
                //Alright, I've decoded data. Now what? Well, let's use compact map and put it into an array.
                let posts = postsDictionary.compactMap({$0.value})
                self.posts = posts
                completion()
            } catch {
                print("There was an error in \(#function): \(error) \(error.localizedDescription)")
                completion()
                return
            }
        } .resume()
    }
    
    
    //Create:
    func postPost(cohort: String, name: String, reason: String, completion: @escaping() -> Void) {
        //Alright, now here we need to create a post. So, our parameters will need to take in a cohort, name, and reason. Along with the completion of course.
        //Let's unwrap and build the URL for the request.
        guard var url = baseUrl else {completion(); return}
        url.appendPathExtension("json")
        //Now create the request and attach this guy.
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        //We cannot yet set the httpBody; we need to have data to do that.
        //httpBody = JSON.encoded data.
        //Initialize our post here:
        let newPost = Post(cohort: cohort, name: name, reason: reason)
        //We have a post, we need to encode it.
        do {
            let data = try JSONEncoder().encode(newPost)
            request.httpBody = data
        } catch {
            print("There was an error in \(#function): \(error) \(error.localizedDescription)")
            completion()
            return
        }
        //Now let's call the data task to do its thing.
        URLSession.shared.dataTask(with: request) { (_, _, error) in
            if let error = error {
                print("\(error.localizedDescription) \(error) in function: \(#function)")
                completion()
                return
            }
            //If we've got data, we should store it into our local source of truth.
            self.posts.append(newPost)
            completion()
        } .resume()
    }
}
