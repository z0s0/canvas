import React, {useState, useEffect} from 'react'
import {Row, Col, Card, Divider} from 'antd'

import { getListDrawings } from '../../lib/api'
import { Drawing } from '../../lib/types'
import DrawingCard from '../../ui/DrawingCard'

export default () => {
    const [drawings, setDrawings] = useState<Drawing[]>([])
    const [errors, setErrors] = useState<string[]>([])

    useEffect(() => {
        getListDrawings()
        .then(resp => setDrawings(resp.data))
        .catch(err => setErrors(["unable to fetch drawings from server"]))
    }, [])

    return(
        <Card>
            <Row>
                <Col span={16} offset={4}>
                {errors.map(err => <span key={err}>{err}</span>)}
                {
                  drawings.map(drawing => 
                    <>   
                      <DrawingCard drawing={drawing} key={drawing.id}/>
                      <Divider/>
                   </> 
                )}
                </Col>
            </Row>
          
        </Card>
    )
}
