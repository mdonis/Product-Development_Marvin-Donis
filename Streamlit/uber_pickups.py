# -*- coding: utf-8 -*-
"""
Created on Wed Nov  3 19:54:47 2021

@author: mdonis
"""

import streamlit as st
import pandas as pd
import math


st.title('Uber pickups test')

DATA_SOURCE = 'https://s3-us-west-2.amazonaws.com/streamlit-demo-data/uber-raw-data-sep14.csv.gz'



@st.cache
def download_data():
    df = pd.read_csv(DATA_SOURCE).rename(columns = {'Lat':'lat','Lon':'lon'})
    df['Date/Time'] = pd.to_datetime(df['Date/Time'] , format='%m/%d/%Y %H:%M:%S')
    return df


df = download_data()



page_size = 1000
total_pages = math.ceil(len(df)/page_size)
slider = st.slider('Select the page', 1, total_pages)

st.write('page selected', slider, 'with limits', ((slider-1)*page_size,(slider*page_size)-1))    

hour_range = st.slider('Select the hour range',
                           0,24, (6,18))

st.write('The range selected is:', hour_range)
                               
df = df.loc[(slider-1)*page_size:(slider*page_size)]
tdf = df[df['Date/Time'].dt.hour.between(hour_range[0],hour_range[1])]
tdf

st.map(tdf)


st.bar_chart(df[['Date/Time','Base']].groupby(df['Date/Time'].dt.hour).count()['Base'])                             

