//
//  TracingPopupQuiz.swift
//  FinalProject
//
//  Created by Benny Kurniawan on 29/01/19.
//  Copyright © 2019 Kelompok 3. All rights reserved.
//

import Foundation
import SpriteKit

class TracingPopupQuiz: BasePopupQuiz {
    private weak var questionBackground: SKSpriteNode!
    private weak var answerCanvas: SKSpriteNode!
    
    private weak var differenceNode: SKSpriteNode!
    private weak var backgroundTraceQuiz: SKSpriteNode!
    
    private var original_isTransparent: Double!
    private var lastPoint = CGPoint.zero
    
    private var currentlyChecking = false
    private var colorStroke:UIColor!
    private var imageArray:[UIImage]!
    
    private var tracingDisable:Bool = false
    
    private var defaultAnswerImage:UIImage!
    private var indexImage:Int = 0
    
    init(size:CGSize, alphabetName:String) {
        super.init()
        let questionBackgroundColor = UIColor.clear
        let canvasPosition = CGPoint(x: 0, y: 0)
        let canvasSize = CGSize(width: 230, height: 230)
        
        colorStroke = UIColor(named: "A_Color")
        
        var pathsOfImage = Bundle.main.paths(forResourcesOfType: "png", inDirectory: "Alphabet/A")
        pathsOfImage.sort()
        imageArray = pathsOfImage.map({ (path) -> UIImage in
            return UIImage(contentsOfFile: path)!
        })
        
        let questionImage = imageArray[indexImage]
        
        let questionBackground = SKSpriteNode(texture: SKTexture(image: questionImage))
        questionBackground.position = canvasPosition
        questionBackground.size = canvasSize
        addChild(questionBackground)
        self.questionBackground = questionBackground
        
        defaultAnswerImage = UIImage(color: questionBackgroundColor, size: questionImage.size)
        let answerCanvasTexture = SKTexture(image: defaultAnswerImage)
        let answerCanvas = SKSpriteNode(texture: answerCanvasTexture)
        answerCanvas.position = canvasPosition
        answerCanvas.size = canvasSize
        answerCanvas.alpha = 0.5
        addChild(answerCanvas)
        self.answerCanvas = answerCanvas

        //delete differenceNode after testing
        let differenceNode = SKSpriteNode(texture: SKTexture(image: UIImage(color: questionBackgroundColor, size: canvasSize)!))
        let outsideOfScreen = CGPoint(x: UIScreen.main.bounds.midX , y: UIScreen.main.bounds.midY-250) //max x max y hilang
        differenceNode.position = outsideOfScreen
        differenceNode.size = canvasSize
        addChild(differenceNode)
        self.differenceNode = differenceNode
        add_difference_to_differenceNode()
        original_isTransparent = differenceNode.getImage()!.getRatio_ofNotTransparentPixels()
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let touch = touches.first else {return}
        let touchLocation = touch.location(in: self)
        guard questionBackground.contains(touchLocation) else {return}
        
        let startPositionColorCorrect = questionBackground.getColor(touch: touch).cgColor.isColorNearBlack()
        guard startPositionColorCorrect else {
            tracingDisable = true
            return
        }
        
        lastPoint = touchLocation
    }
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard tracingDisable == false else {return}
        guard let touch = touches.first else {return}
        let touchLocation = touch.location(in: self)
    
        guard questionBackground.contains(touchLocation) else {return}
        let alphaQuestions = questionBackground.getColor(touch: touch).cgColor.alpha
        guard alphaQuestions == 1 else {return}
        guard lastPoint != CGPoint.zero else {lastPoint = touchLocation ;return}
        drawLine(from: lastPoint, to: touchLocation)
        lastPoint = touchLocation
    }
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard tracingDisable == false else { tracingDisable = false; return}
        add_difference_to_differenceNode()
        let diffrenceBlackPixel = differenceNode.getImage()?.getRatio_ofBlackPixels_fromAllPixels()
        guard diffrenceBlackPixel == 0 else { handleStrokeWrong() ;return}
        
        indexImage += 1
        handleStrokeCorrect()
    }
    
    private func check_answer() {
        guard currentlyChecking == false else { return }
        
        currentlyChecking = true
        let difference = differenceNode.getImage()!
        let correctTracingRatio = difference.getRatio_ofBlackPixels_fromAllPixels()
        let allowableMarginOfError_percentage = 0.06// 0.01 == 1 %
        let required_correctTracingRatio = (original_isTransparent - allowableMarginOfError_percentage)
        
        let player_traceCorrectly = correctTracingRatio > required_correctTracingRatio
        
        if  player_traceCorrectly {
            print("correct")
            gameDelegate?.handleAnswerCorrect()
        } else {
            print("wrong")
        }
        Timer.scheduledTimer(withTimeInterval: 1.5, repeats: false) { (_) in
            self.currentlyChecking = false
        }
    }
    
    private func add_difference_to_differenceNode(){
        UIGraphicsBeginImageContext(differenceNode.frame.size)
        guard let context = UIGraphicsGetCurrentContext() else {return}
        context.translateBy(x: -differenceNode.frame.minX, y: -differenceNode.frame.minY)
        
        context.draw(questionBackground.getImage()!, in: differenceNode.frame)
        //        context.setBlendMode(.difference)
        context.draw(answerCanvas.getImage()!, in: differenceNode.frame)
        
        differenceNode.texture = SKTexture(image: UIGraphicsGetImageFromCurrentImageContext()!)
        differenceNode.alpha = 1.0
        UIGraphicsEndImageContext()
    }
    
    private func drawLine(from fromPoint: CGPoint, to toPoint: CGPoint) {
        
        UIGraphicsBeginImageContext(answerCanvas.frame.size)
        guard let context = UIGraphicsGetCurrentContext() else {return}
        context.translateBy(x: -answerCanvas.frame.minX, y: -answerCanvas.frame.minY)
        
        UIImage(cgImage: answerCanvas.getImage()!).draw(in: answerCanvas.frame)
        
        context.move(to: reverseCoordinate(fromPoint))
        context.addLine(to: reverseCoordinate(toPoint))
        
        context.setLineCap(.round)
        context.setBlendMode(.normal)
        context.setLineWidth(40.0)
        context.setStrokeColor(colorStroke.cgColor)
        
        context.strokePath()
        
        answerCanvas.texture = SKTexture(image: UIGraphicsGetImageFromCurrentImageContext()!)
        answerCanvas.alpha = 0.5
        UIGraphicsEndImageContext()
    }
    
    private func reverseCoordinate(_ point: CGPoint) -> CGPoint {
        let x = point.x
        let y = (UIScreen.main.bounds.maxY - point.y) - 2*(UIScreen.main.bounds.midY - answerCanvas.frame.midY)
        return CGPoint(x: x, y: y)
    }
    
    private func handleStrokeCorrect() {
        //transisi next pic
    
        guard indexImage == imageArray.count else {
            DispatchQueue.main.async {
                self.questionBackground.texture = SKTexture(image: self.imageArray[self.indexImage]) //next image
                self.answerCanvas.texture = SKTexture(image: self.defaultAnswerImage) //reset canvas
            }
            return
        }
        gameDelegate?.handleAnswerCorrect()
    }
    
    private func handleStrokeWrong() {
        //erase stroke
        answerCanvas.texture = SKTexture(image: defaultAnswerImage)
        animationAnswerWrong(node: questionBackground)
    }
    
    private func animationAnswerWrong(node:SKSpriteNode) {
        let originNode = node.position
        let x = originNode.x
        let y = originNode.y
        let deltaX: CGFloat = 5.0
        let bounceRight = SKAction.move(to: CGPoint(x: x + deltaX, y: y), duration: 0.1)
        let bounceLeft = SKAction.move(to: CGPoint(x: x - deltaX, y: y), duration: 0.1)
        let backToOrigin = SKAction.move(to: originNode, duration: 0.1)
        let sequence = SKAction.sequence([bounceRight,bounceLeft,bounceRight,bounceLeft, backToOrigin])
        node.run(sequence)
    }

}

public extension UIImage {
    public convenience init?(color: UIColor, size: CGSize) {
        let rect = CGRect(origin: .zero, size: size)
        UIGraphicsBeginImageContextWithOptions(rect.size, false, 0.0)
        color.setFill()
        UIRectFill(rect)
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        guard let cgImage = image?.cgImage else { return nil }
        self.init(cgImage: cgImage)
    }
}
public extension CGImage {
    func getTotalPixels() -> Int {
        return self.width * self.height
    }
    func getTotalBlackPixels() -> Int {
        let imageData: CFData = self.dataProvider!.data!
        let pixels = CFDataGetBytePtr(imageData)!
        let bytesPerPixel = 4
        let width = self.width
        let height = self.height
        var totalBlackPixels = 0
        for y in 0..<height {
            for x in 0..<width {
                let pixelStartIndex = (x + (y * width)) * bytesPerPixel
                let r = pixels[pixelStartIndex]
                let g = pixels[pixelStartIndex + 1]
                let b = pixels[pixelStartIndex + 2]
                let a = pixels[pixelStartIndex + 3]
                
                let pixel_isBlack = (r < 30 && g < 30 && b < 30 && a == 255)
                if pixel_isBlack {
                    totalBlackPixels += 1
                }
            }
        }
        return totalBlackPixels
    }
    func getTotal_nonTransparent() -> Int {
        let imageData: CFData = self.dataProvider!.data!
        let pixels = CFDataGetBytePtr(imageData)!
        let bytesPerPixel = 4
        let width = self.width
        let height = self.height
        var totalAlpha = 0
        for y in 0..<height {
            for x in 0..<width {
                let pixelStartIndex = (x + (y * width)) * bytesPerPixel
                let a = pixels[pixelStartIndex + 3]
                
                let pixel_isNotTransparent = ( a >= 100 )
                if pixel_isNotTransparent {
                    totalAlpha += 1
                }
            }
        }
        return totalAlpha
    }
    func getRatio_ofBlackPixels_fromAllPixels() -> Double {
        if self.getTotalPixels() == 0 {
            print("WARNING: 0 pixel image")
            return 0.0
        }
        return Double(self.getTotalBlackPixels()) / Double(self.getTotalPixels())
    }
    func getRatio_ofNotTransparentPixels() -> Double {
        guard self.getTotalPixels() > 0 else {return 0.0}
        return Double(self.getTotal_nonTransparent()) / Double(self.getTotalPixels())
        
    }
}

public extension SKSpriteNode {
    func getImage() -> CGImage? {
        return self.texture?.cgImage()
    }
}

public extension CGImage {
    func getColor(x: Int, y: Int)->UIColor{
        let imageData: CFData = self.dataProvider!.data!
        let pixels = CFDataGetBytePtr(imageData)!
        let startIndex = (self.width * y + x) * 4
        
        let r = CGFloat(pixels[startIndex]) / CGFloat(255.0)
        let g = CGFloat(pixels[startIndex+1]) / CGFloat(255.0)
        let b = CGFloat(pixels[startIndex+2]) / CGFloat(255.0)
        let a = CGFloat(pixels[startIndex+3]) / CGFloat(255.0)
        
        return UIColor(red: r, green: g, blue: b, alpha: a)
    }
}

public extension SKSpriteNode {
    func getColor(touch: UITouch) -> UIColor {
        let position = touch.location(in: self)
        let image = self.texture!.cgImage()
        
        let widthScaleFactor = self.size.width/CGFloat(image.width)
        let x = Int((position.x + (self.size.width/2)) / widthScaleFactor)
        
        let heightScaleFactor = self.size.height/CGFloat(image.height)
        var y = Int((position.y + (self.size.height/2)) / heightScaleFactor)
        let halfHeight = image.height / 2
        let difference = y - halfHeight
        y = halfHeight - difference
        
        let color = image.getColor(x: x, y: y)
        return color
    }
}

public extension CGColor {
    func isColorNearBlack() -> Bool {
        guard let color = self.components else {return false}
        let red = color[0]
        let green = color[1]
        let blue = color[2]
        let alpha = color[3]
        guard alpha == 1.0 else {return false}
        
        return (red <= 0.3 && green <= 0.3 && blue <= 0.3)
    }
}
