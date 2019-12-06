//
//  ViewController.swift
//  dic
//
//  Created by Gilmer Marcano on 11/22/19.
//  Copyright © 2019 Gilmer Marcano. All rights reserved.
//

import UIKit
import WebKit

class ViewController: UIViewController {
    
    @IBOutlet weak var webView: WKWebView!
    
    @IBOutlet weak var textField: UITextField!
    
    var palabra:String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
    }
    @IBAction func buscar(_ sender: Any) {
          
    palabra = textField.text!
   
        
        
        let urlCompleto = "https://es.wikipedia.org/w/api.php?action=query&prop=extracts&format=json&exintro=&titles=\(palabra!.replacingOccurrences(of: " ", with: "20%"))"
        
        
    let objetoUrl = URL(string:urlCompleto)
        
        
               
    let tarea = URLSession.shared.dataTask(with: objetoUrl!) { (datos, respuesta, error) in
                   
        if error != nil {
                       
            print(error!)
                       
        } else {
                      
            do{
            
                let json = try JSONSerialization.jsonObject(with: datos!, options: JSONSerialization.ReadingOptions.mutableContainers) as! [String:Any]
                       
            //print(json)
            //se comienza a bajar de niveles en el json
            
                let querySubJson = json["query"] as! [String:Any]
              
            //print(querySubJson)
            
            let pagesSubJson = querySubJson["pages"] as! [String:Any]
            
            //print(pagesSubJson)
            
            let pageId = pagesSubJson.keys //esto es para obtener el valor de la llave de pages y poder acceder a cualquier llave diferente.
            let primeraLlave = pageId.first! // es para obtener el valor de la primera llave que es la que siempre me interesa. (esto puedo verlo en el json).
            
            let idSubJson = pagesSubJson[primeraLlave] as! [String:Any]
            
            //print(idSubJson)
            
            let extractStringHtml = idSubJson["extract"] as! String
            
            //print(extractStringHtml)
            
            DispatchQueue.main.sync(execute: {
                self.webView.loadHTMLString(extractStringHtml, baseURL: nil)
            })
            
        }catch {
                           
        print("El Procesamiento del JSON tuvo un error")
                           
        }
                   
        }
               
        }
           
        tarea.resume()
           
        }
    
    }
    



