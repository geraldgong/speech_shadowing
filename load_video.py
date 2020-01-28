from auditok import split
from auditok import AudioRegion
audio_regions = split('./data/Track 2.wav')
for region in audio_regions:
    region.play(progress_bar=True)

# region = AudioRegion.load('./data/Track 2.wav')
#
# region.split_and_plot()