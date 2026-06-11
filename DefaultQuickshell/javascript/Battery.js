function getColour() {
    const percent = Math.round(UPower.displayDevice.percentage * 100)
    if (percent < 20) {
	return "#f38ba8"
    } else if (percent < 50) {
	return "#f9e2af"
    }
    return "#a6e3a1"
}
