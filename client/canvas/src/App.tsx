import React from 'react';
import {Layout} from 'antd'
import Drawings from './features/drawings'

import "./main.css"

const { Header, Footer, Sider, Content } = Layout;

export default () =>
  <Layout>
    <Header/>
    
    <Layout>
      <Sider/>
        <Content>
          <Drawings/>
        </Content>
      <Sider/>
    </Layout>

    <Footer/>
  </Layout>
