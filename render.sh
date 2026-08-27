typst compile -f png --pages 1 --ppi 250 main.typ promo/page_1.png
typst compile -f png --pages 3 --ppi 250 main.typ promo/page_2.png
typst compile -f png --pages 4 --ppi 250 main.typ promo/page_3.png

# FIT-Presentation promo images (title, content, thank-you)
typst compile -f png --pages 1 --ppi 250 slides.typ promo/slide_1.png
typst compile -f png --pages 2 --ppi 250 slides.typ promo/slide_2.png
typst compile -f png --pages 6 --ppi 250 slides.typ promo/slide_3.png