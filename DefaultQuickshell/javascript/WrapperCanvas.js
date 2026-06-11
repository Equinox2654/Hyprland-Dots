
function addPoint(ctx, x, y, r, curveIn = false, onX = true, left = true, down = true) {
    const xDir = left ? -1 : 1;
    const yDir = down ? 1 : -1;

    if (curveIn) {
        if (onX) {
            ctx.lineTo(x + xDir * r, y);
            ctx.quadraticCurveTo(x + xDir * r, y + yDir * r, x, y + yDir * r);
        } else {
            ctx.lineTo(x, y + yDir * r);
            ctx.quadraticCurveTo(x + xDir * r, y + yDir * r, x + xDir * r, y);
        }
    } else {
        if (onX) {
            ctx.lineTo(x + xDir * r, y);
            ctx.quadraticCurveTo(x, y, x, y + yDir * r);
        } else {
            ctx.lineTo(x, y + yDir * r);
            ctx.quadraticCurveTo(x, y, x + xDir * r, y);
        }
    }
}

function drawBluetooth(ctx, x, y, width, height) {

    const top = 10
    const bottom = ctx.canvas.height
    const right = ctx.canvas.width
    const left = 60

    if (width < 1) return;

    const r = Math.min(30, width / 2)

    ctx.beginPath(0, 0)

    ctx.lineWidth = 10
    ctx.strokeStyle = "rgba(180, 190, 254, 1)"

    ctx.moveTo(x, y - r * 2)

    ctx.lineTo(x, y - r)

    addPoint(ctx, x, y, r, false, false, false, false)

    addPoint(ctx, x + width, y, r, false, true, true, true)

    addPoint(ctx, x + width, bottom, r, false, false, false, false)

    ctx.lineTo(x, 1180)

    ctx.stroke()

    ctx.closePath()
    
    ctx.fillStyle = "#1e1e2e"
    ctx.fill()
}

function draw(ctx, width, height) {
    ctx.clearRect(0, 0, width, height)

    const r = 30

    const top = 10
    const bottom = ctx.canvas.height - 10
    const right = ctx.canvas.width - 10
    const left = 60

    ctx.beginPath()

    ctx.moveTo(0, 0)
    ctx.lineTo(0, height)
    ctx.lineTo(width, height)
    ctx.lineTo(width, 0)
    ctx.lineTo(0, 0)
    ctx.closePath()

    ctx.lineWidth = 10
    ctx.strokeStyle = "rgba(180, 190, 254, 1)"

    ctx.moveTo(left, bottom - r)

    addPoint(ctx, left, top, r, false, false, false, true)

    addPoint(ctx, right, top, r, false, true, true, true)

    addPoint(ctx, right, bottom, r, false, false, true, false)

    addPoint(ctx, left, bottom, r, false, true, false, false)

    ctx.closePath()

    ctx.stroke()

    ctx.fillStyle = "#1e1e2e"
    ctx.fill("evenodd")
}
