require ["glasto-rq-graphics"], (gr) ->
        # Doesn't work: guessing that the window has already loaded:
        #window.onload = gr.onload

        gr.onload()
