import axios from 'axios'
import { Drawing } from './types'

const API_URL = "http://localhost:5000"

export const getListDrawings = () =>
  axios.get<Drawing[]>(`${API_URL}/drawings`)
