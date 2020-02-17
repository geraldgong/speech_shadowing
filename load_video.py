import numpy as np
import matplotlib.pyplot as plt
import soundfile as sf
import sounddevice as sd

data, fs = sf.read('./data/Track 2.wav',  dtype='float32')
d = np.random.random_sample(100000)
sd.play(d, fs)

status = sd.wait()