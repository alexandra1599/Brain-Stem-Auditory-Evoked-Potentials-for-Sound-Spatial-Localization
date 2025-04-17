# Brain-Stem-Auditory-Evoked-Potentials-for-Sound-Spatial-Localization

In this project you will be analyzing electrical potentials that are closely related to hearing
in humans. You will look into how sound in one ear aﬀects the neural processing in the other
ear. You will also look into how the neuronal circuits of the brain might utilize delays in
sound arriving into diﬀerent ears to localize the source of the sound. Although the treatment
is restricted to simulated Auditory Evoked potentials, the techniques you will be applying
will apply to a wide variety of evoked potentials of the brain.


1.1 The Brainstem Auditory Evoked potential

An evoked potential is the electrical manifestation of response in various neuronal circuitry of
the brain to diﬀerent sensory stimuli. Among the various sensory modalities, the processing
of inputs has specific signatures that neurologists look for and to utilize into assessing normal
function and pathology. Auditory evoked potentials are the hallmarks of neuronal processing
of sound stimuli. Fortunately, detecting these potentials can be done from the surface of the
body (albeit very small voltages in the microvolt range) by recording potential diﬀerences
between an area of interest and a reference electrode on the body. The early compnents
of an auditory evoked potential (< 12 msec) originate from the brainstem and are called
”brainstem auditory evoked potentials” (BAEP). Near the head, BAEP response to a click
sound is approximately 1 µV in magnitude and consists of 5 to 6 sharp peaks separated by
1 msec.
It is obvious that BAEP will result from clicks arriving to each of the ears for normal
subjects. In this project we will be looking at BEAPs recorded when a seris of audible clicks
are delivered via earphones to the left ear (BAEPL), then to the right ear (BAEPR), then
to both ears simultaneously (BAEPB).
Since the auditory nerve fibers from each ear pass through the brainstem and excite
neuronal circuits there, the neuronal groups responsible for such processing, therefore, could
be diﬀerent. It is expected, however, that at some point in the pathway some common

neuronal group will process both left- and right- ear inputs. If this were not the case, then
we would expect that the BAEP recorded when a sound is applied to both ears will simply
be the sum of the BEAPs recorded when sound is applied to each ear separately (and hence
have completely separate processing pathways) since electric fields satisfy the superposition
principle. Thus, we can compute a binaural diﬀerence waveform which is the sum of the left
ear only BAEP and the right ear only BAEP minus the both ears BAEP :

                                BID = BAEPL + BAEPR−BAEPB (1)
                                
A nonzero BID therefore indicates that a population of neurons must be responding to
stimuli from both ears. These neurons are likely to play a role in sound localization. That
is, the changes in the BID waveform are related to the delay in arrival of sounds between
both ears. You will thus also examine how the binaural diﬀerence waveform is aﬀected by
diﬀerences in the times of arrival of the clicks at each ear.
As with any evoked potential recordings, the signal level is too small. Therefore, the
BAEP is not the only signal the electrodes placed at the head will pick up. The electrical
activity of muscles (including the heart), 60 Hz line noise, and other non-relevant neural
activity will also be recorded by the electrodes, which will all make for a quite low signal-to
noise ratio. What makes this lab exercise interesting therefore, is that the signal is much
smaller than the noise in each click trial. Therefore, to overcome such a problem a large
number of clicks separated in time can be supplied and the associated signal recorded for
each trial. It could then be possible to average across trials to get a mean BAEP signal.
This technique is valid so long as the BAEP signal is approximately the same for each click
and as long as the clicks are separated by long enough intervals.


1. Mean BAEP and confidence intervals: read into matlab the simulated data files of
BEAP, which include click responses from left ear, right ear and both ears ( noisy-left,
noisy-right, and noisy-both). Each file contains 2000 click trials of around 12.5 msec
sampled at 20KHz.

a. Construct estimate of the mean BAEP for each ear, BAEPL, BAEPR, and BAEPB.
Plot those along with a typical click trial. Label the time axis in milliseconds,
and the signal axis in microvolts.
b. On the same figures, plot the 95% confidence intervals for each estimate (hint:
look into the previous section). Comment on the quality of your estimate based
on these confidence intervals.
2. Signal to Noise ratio. You will observe the change in the signal quality before and
after averaging.
SNR=power in signal/power in noise 
a. Obtain an estimate of the SNR for a typical observation (click trial) for each ear.
Note that since for each trial the signal looks mostly like noise, you need to think
carefully how to obtain the ratio in equation 10.
b. Obtain, on average, an estimate of the SNR for the average BAEP you arrived at
in part 1(a). Note here that you also need to determine a measure of the average
noise. hint: again, read the theory section carefully. What is the signal here?
what is the noise? How is the standard error of your estimate se[n] related to the
noise in the averaged BAEP?
c. Compare the SNR values you arrived at for each click trial with the SNR values
you obtain for the estimated BAEP. Is this result expected? Discuss.
3. Testing the no correlation assumption: An assumption made in part 2(b) for com-
puting confidence intervals is that the successive trials (epochs) are uncorrelated. To
test the validity of this assumption, compute and plot the epoch by epoch value of the
autocovariance function of the raw data (see Matlab function xcov. We know that
autocovariance of a white noise signal is an impulse at the origin. How well does our
data fit into this assumption?
4. Finding the Binaural Diﬀerence waveform (BID). As we have seen earlier, the
BID is an indication of common neuronal processing pathways between left and right
ears.
a. Compute the Binaural diﬀerence waveform (BID) for each click, then estimate
the average BID. That is, find the diﬀerence between the sum of the left ear and
right ear responses and the response of both ears. Be careful with the DC values
of all the signals.(hint: You need to find an average of the DC values and subtract
that too).
b. How do you assess whether the BID you obtained is not actually due to noise?
Plot the BID along with its confidence intervals.
5. Eﬀect of interaural time diﬀerence. We now apply clicks to diﬀerent ears BAEPL
and BAEPR. We also apply clicks to both ears BAEPB but with some time diﬀerence
between the clicks. This creates a binaural diﬀerence waveform which has a signature
wave called the β potential which is proportional for the diﬀerence of click arrival and
could be used by the neuronal circuitry to localize sound.
Read into matlab the files ITD02, ITD04, ITD12, and ITD16, which contain the
binaural diﬀerence waveforms corresponding to interaural time diﬀerences of 0.2, 0.4,
1.2, and 1.6 msec respectively.
a. Filter the signal to retain only relevant information relevant to finding the beta
potential
b. Design a matched filter to detect the β potential for each ITD. look at figures in
the paper(s) provided) Take into account the following. (1) The β potential will
be the major peak in the binaural diﬀerence waveform. (2) look into the first file,
ITD 0.2 msec, first. (3) You could use some window function for this matching.
c. Is there a delay due to the introduced matched filter? Discuss how we can account
for that delay.
d. Plot β as a function of ITD for the above results. Show how your matched filter
can detect the magnitude and the latency of the Beta potential. Is there an ITD
for which the beta potential essentially disappears?
e. Is the values that you obtained is what you expected given the biological knowl-
edge of the problem? Discuss.
useful Matlab commands: find, fir1, firls, filtfilt, xcorr, xcov, filter, std, mean


