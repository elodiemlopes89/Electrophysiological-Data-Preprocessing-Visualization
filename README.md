# Electrophysiological-Data-Preprocessing-Visualization
Functions created under the framework of the PhD thesis "Novel Contributions to Personalized Brain Stimulation Biomarkers for Better Management of Neurological Disorders": Doctoral Program of Biomedical Engineering (Faculty of Engineering of University of Porto).

## preprocessing_eeg.m
This function processes raw electrophysiological data by performing several operations:
1. Channel removal (based on provided labels)
2. Re-referencing (optional, based on average montage)
3. Resampling of the data
4. Bandpass filtering (using a 4th-order Butterworth filter)

## eeg_visual0.m
This function plot electrophysiolical data, with the possibility to plot vertical lines.
