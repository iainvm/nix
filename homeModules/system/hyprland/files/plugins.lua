hl.config({
    plugin = {
        dynamic_cursors = {
            enabled = true,
            mode = "none",
            shake = {

                -- enables shake to find
                enabled = true,

                -- controls how soon a shake is detected
                -- lower values mean sooner
                threshold = 6.0,

                -- magnification level immediately after shake start
                base = 4.0,
                -- magnification increase per second when continuing to shake
                speed = 4.0,
                -- how much the speed is influenced by the current shake intensity
                influence = 0.0,

                -- maximal magnification the cursor can reach
                -- values below 1 disable the limit (e.g. 0)
                limit = 0.0,

                -- time in milliseconds the cursor will stay magnified after a shake has ended
                timeout = 1000,

                -- show cursor behaviour `tilt`, `rotate`, etc. while shaking
                effects = false,

                -- enable ipc events for shake
                -- see the `ipc` section below
                ipc = false,
            },

        }
    }
})
