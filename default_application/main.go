package main

import (
	"fmt"
	"image"
	"image/color"

	"gocv.io/x/gocv"

	"log"

	"github.com/actes2/go_image_streaming"
)

func main() {
	fmt.Println("Init!")

	baseImage, err := gocv.ImageToMatRGB(go_image_streaming.Listen_for_UDP_stream("6614", 0))
	if err != nil {
		log.Println(err)
		return
	}
	defer baseImage.Close()
	// baseImage := gocv.IMRead("base.png", gocv.IMReadColor)
	// if baseImage.Empty() {
	// 	fmt.Println("Error with image")
	// 	return
	// }
	// defer baseImage.Close()

	templateImage := gocv.IMRead("template.png", gocv.IMReadColor)
	if baseImage.Empty() {
		fmt.Println("Error with image")
		return
	}
	defer templateImage.Close()

	fmt.Println(templateImage.Cols(), templateImage.Rows())
	result := gocv.NewMat()
	defer result.Close()

	mask := gocv.NewMat()
	defer mask.Close()

	gocv.MatchTemplate(baseImage, templateImage, &result, gocv.TmCcoeffNormed, mask)
	threshold := 0.8

	for y := 0; y < result.Rows(); y++ {
		for x := 0; x < result.Cols(); x++ {
			if result.GetFloatAt(y, x) >= float32(threshold) {

				rect := image.Rect(x, y, x+templateImage.Cols(), y+templateImage.Rows())
				gocv.Rectangle(&baseImage, rect, color.RGBA{R: 255, G: 0, B: 0, A: 0}, 1)

				fmt.Printf("%f, the cords: %d,%d\n", result.GetFloatAt(y, x), x, y)
				fmt.Println("Match found")
			}
		}
	}

	// if maxVal < float32(threshold) {
	// 	fmt.Println("No match found!")
	// 	return
	// }

	// Set the region of the result matrix to zero to suppress this match

	gocv.IMWrite("output.png", baseImage)

}
