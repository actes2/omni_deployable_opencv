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

	// Take in an image from UDP port 6614 on our current machine, then convert that to an OpenCV Mat
	baseImage, err := gocv.ImageToMatRGB(go_image_streaming.Listen_for_UDP_stream("6614", 0))
	if err != nil {
		log.Println(err)
		return
	}
	defer baseImage.Close()

	// Read whatever our template image is.
	templateImage := gocv.IMRead("template.png", gocv.IMReadColor)
	if baseImage.Empty() {
		log.Println("Error with image")
		return
	}
	defer templateImage.Close()

	// Print off our columns and rows, this can probably be commented out, but it's a great indicator that things are working.
	log.Println(templateImage.Cols(), templateImage.Rows())

	// Our result Mat to which we write our conclusions to.
	result := gocv.NewMat()
	defer result.Close()

	// We don't use a mask in this context, but unfortunately we have to instantate 'something' to fit in the method temorarily.
	mask := gocv.NewMat()
	defer mask.Close()

	// Match the incoming image from above, to our template image
	gocv.MatchTemplate(baseImage, templateImage, &result, gocv.TmCcoeffNormed, mask)
	threshold := 0.8

	for y := 0; y < result.Rows(); y++ {
		for x := 0; x < result.Cols(); x++ {
			if result.GetFloatAt(y, x) >= float32(threshold) {

				rect := image.Rect(x, y, x+templateImage.Cols(), y+templateImage.Rows())
				gocv.Rectangle(&baseImage, rect, color.RGBA{R: 255, G: 0, B: 0, A: 0}, 1)

				// Output from each find, if you're reworking my code remember I/O things take cycles and slow things down. Probably best to just comment this out.
				log.Printf("%f, the cords: %d,%d\n", result.GetFloatAt(y, x), x, y)
				log.Println("Match found")
			}
		}
	}

	// Finish up by writing our output to the active directory.
	gocv.IMWrite("output.png", baseImage)
}
