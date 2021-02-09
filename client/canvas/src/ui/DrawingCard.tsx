import React, { CSSProperties } from 'react'
import { Drawing, Matrix, Rectangle, Flood} from '../lib/types'

interface Props {
    drawing: Drawing
}

// passing array index to component key prop is a bad idea, but rectangles are not globally identifiable for simplicity
export default ({drawing}: Props): React.FunctionComponentElement<Props> => 
  <div>
      <span>ID: {drawing.id}</span>
    
      {
          drawing.rectangles.map((rectangle, idx) => 
              <>
                <span>Rectangle {idx + 1}:</span> <RectangleDefinitionBox key={idx} rectangle={rectangle}/>
              </>)
      }
    
      <span>Flood:</span> {drawing.flood ? <FloodBox flood={drawing.flood}/> : "null"} 
      <MatrixBox matrix={drawing.matrix}/>
  </div>

interface MatrixBoxProps {
    matrix: Matrix<string>
}
const MatrixBox = ({matrix}: MatrixBoxProps): React.FunctionComponentElement<MatrixBoxProps> => {
  return(
      <div>
        {matrix.map(row => {
            return (
                <>
                  {row.map(sym => <Cell key={sym} symbol={sym}/>)}
                  <br/>
                </>
            )

        })}
      </div>
  )
}

interface RectangleDefinitionBoxProps {
  rectangle: Rectangle 
}

const RectangleDefinitionBox = ({rectangle}: RectangleDefinitionBoxProps): React.FunctionComponentElement<RectangleDefinitionBoxProps> =>
  <div>
    <span>Width: {rectangle.width}</span>
    <span>Height: {rectangle.height}</span>
    <span>Starts from: x = {rectangle.coordinates[0]}, y = {rectangle.coordinates[1]}</span>
    <span>Fill symbol: {rectangle.fillSymbol ? rectangle.fillSymbol : "null"}</span>
    <span>Outline symbol: {rectangle.outlineSymbol ? rectangle.outlineSymbol : "null"}</span>
  </div>

interface CellProps {
  symbol: string
}

const Cell = ({symbol}: CellProps): React.FunctionComponentElement<CellProps> => {
    const style: CSSProperties = {
        minWidth: "20px",
        minHeight: "20px",
        margin: "1px", 
        border: "1px solid",
        display: "inline-block"
    } 

    return(
        <span style={style}>{symbol === " " ? <>&nbsp;</> : symbol}</span>
    )
}

interface FloodDefinitionProps {
    flood: Flood
}

const FloodBox = ({flood}: FloodDefinitionProps): React.FunctionComponentElement<FloodDefinitionProps> => 
  <div>
      <span>Fill symbol: {flood.fillSymbol}</span>
      <span>Start from: x = {flood.startCoordinate[0]} y = {flood.startCoordinate[1]}</span>
  </div>
