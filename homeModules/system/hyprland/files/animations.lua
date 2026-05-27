hl.curve(
    "overShoot", {
        type = "bezier",
        points = {
            { 0.23, 1 },
            { 0.32, 1 }
        }
    }
)

hl.animation = ({
    "windows",
    enabled = true,
    speed = 7,
    bezier = "overSheet",
})

hl.animation = ({
    "windowsOut",
    enabled = true,
    speed = 7,
    bezier = "default",
    style = "popin 80%",
})

hl.animation = ({
    "border",
    enabled = true,
    speed = 10,
    bezier = "default",
})

hl.animation = ({
    "borderangle",
    enabled = true,
    speed = 8,
    bezier = "default",
})

hl.animation = ({
    "fade",
    enabled = true,
    speed = 7,
    bezier = "default",
})

hl.animation = ({
    "workspaces",
    enabled = true,
    speed = 6,
    bezier = "default",
})
