import React, { CSSProperties } from 'react'
import { Drawing, Matrix, Rectangle, Flood} from '../lib/types'
import {Table, Card, Divider} from 'antd'
import {ColumnsType} from 'antd/es/table'

interface Props {
    drawing: Drawing
}

// passing array index to component key prop is a bad idea, but rectangles are not globally identifiable for simplicity
export default ({drawing}: Props): React.FunctionComponentElement<Props> => 
  <Card>
    
      <Table
        title={() => "Rectangles"}
        dataSource={drawing.rectangles}
        columns={rectanglesColumns}
        bordered
        pagination={false}
      />

      <Divider/>
      <span>Flood:</span> {drawing.flood ? <FloodBox flood={drawing.flood}/> : "null"} 
      <Divider/>
      <span>Human readable representation</span>
      <MatrixBox matrix={drawing.matrix}/>
  </Card>

const rectanglesColumns: ColumnsType<Rectangle> = [
  {title: "width", dataIndex: "width", key: "width"}, 
  {title: "height", dataIndex: "height", key: "height"},
  {title: "Start Coordinate", dataIndex: "coordinates", render: (coordinates) => `(${coordinates[0]}, ${coordinates[1]})`},
  {title: "Outline", dataIndex: "outlineSymbol", render: sym => sym ? sym : "null"},
  {title: "Fill", dataIndex: "fillSymbol", render: sym => sym ? sym : "null"}
]

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
  <Card style={{marginTop: "2%"}}>
      <span>Fill symbol: {flood.fillSymbol}</span>
      <span>Start from: x = {flood.startCoordinate[0]} y = {flood.startCoordinate[1]}</span>
  </Card>
