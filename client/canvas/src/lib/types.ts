
type Coordinate = [number, number]
type UUID = string
export type Matrix<T> = Array<Array<T>>

export interface Flood {
  startCoordinate: Coordinate,
  fillSymbol: string
}

export interface Rectangle {
  width: number,
  height: number,
  coordinates: Coordinate,
  outlineSymbol: string | null,
  fillSymbol: string | null 
}

export interface Drawing {
    id: UUID,
    matrix: Matrix<string>
    flood: Flood | null,
    rectangles: Rectangle[]
}
