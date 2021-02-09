
type Coordinate = [number, number]

interface Flood {
  startCoordinate: Coordinate,
  fillSymbol: string
}

interface Rectangle {
  width: number,
  height: number,
  coordinates: Coordinate,
  outlineSymbol: string | null,
  fillSymbol: string | null 
}

export interface Drawing {
    matrix: Array<Array<string>>,
    flood: Flood,
    rectangles: Rectangle[]
}
