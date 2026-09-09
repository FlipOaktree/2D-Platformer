# Generates placeholder_terrain_tiles.png: a 4x4 atlas of 64-pixel tiles used by
# Module 4, Lesson 1 to build a TileSet terrain that matches sides.
#
# Tile index = Top(1) + Right(2) + Bottom(4) + Left(8), where a set bit means
# "a tile of the same terrain sits on that side". Atlas coordinates are
# (index % 4, index / 4). Exposed sides are painted with a visible band so the
# correct peering bits can be read straight off the artwork.

Add-Type -AssemblyName System.Drawing

$TileSize = 64
$Columns  = 4
$Rows     = 4
$Band     = 12
$Outline  = 2

$Dirt    = [System.Drawing.Color]::FromArgb(255, 122,  92,  67)
$Grass   = [System.Drawing.Color]::FromArgb(255,  94, 156,  74)
$Side    = [System.Drawing.Color]::FromArgb(255, 150, 119,  90)
$Edge    = [System.Drawing.Color]::FromArgb(255,  62,  46,  34)

$bitmap   = New-Object System.Drawing.Bitmap ($Columns * $TileSize), ($Rows * $TileSize)
$graphics = [System.Drawing.Graphics]::FromImage($bitmap)
$graphics.SmoothingMode = [System.Drawing.Drawing2D.SmoothingMode]::None
$graphics.Clear([System.Drawing.Color]::Transparent)

function Fill($color, $x, $y, $w, $h) {
    $brush = New-Object System.Drawing.SolidBrush $color
    $graphics.FillRectangle($brush, $x, $y, $w, $h)
    $brush.Dispose()
}

for ($index = 0; $index -lt ($Columns * $Rows); $index++) {
    $ox = ($index % $Columns) * $TileSize
    $oy = [math]::Floor($index / $Columns) * $TileSize

    $hasTop    = ($index -band 1) -ne 0
    $hasRight  = ($index -band 2) -ne 0
    $hasBottom = ($index -band 4) -ne 0
    $hasLeft   = ($index -band 8) -ne 0

    Fill $Dirt $ox $oy $TileSize $TileSize

    if (-not $hasLeft)   { Fill $Side $ox $oy $Band $TileSize }
    if (-not $hasRight)  { Fill $Side ($ox + $TileSize - $Band) $oy $Band $TileSize }
    if (-not $hasBottom) { Fill $Side $ox ($oy + $TileSize - $Band) $TileSize $Band }
    if (-not $hasTop)    { Fill $Grass $ox $oy $TileSize $Band }

    if (-not $hasLeft)   { Fill $Edge $ox $oy $Outline $TileSize }
    if (-not $hasRight)  { Fill $Edge ($ox + $TileSize - $Outline) $oy $Outline $TileSize }
    if (-not $hasBottom) { Fill $Edge $ox ($oy + $TileSize - $Outline) $TileSize $Outline }
    if (-not $hasTop)    { Fill $Edge $ox $oy $TileSize $Outline }
}

$output = Join-Path $PSScriptRoot 'placeholder_terrain_tiles.png'
$bitmap.Save($output, [System.Drawing.Imaging.ImageFormat]::Png)
$graphics.Dispose()
$bitmap.Dispose()
Write-Output "Wrote $output"
