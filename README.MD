# IM Assessment Project 2018 Spring
This is a interative piano instrument application,it will track the movetion based on different color and give the feedback on instrument according to the position.
# Enviroment Requirement
- Processing installed
- MIDI synthzether installed (Must compatible with Gerneral MIDI Sound Set )
- Webcam avaiable for video capture
# How to setup
1. open the `IM_Remastered.pde` with processing.
2. open the `Config` tab, locale to `MIDI_OUPUT_DEVICES`, please change it to your midi synthesizers input port.
3. click the `Run` button in the processing, and your application is able to run.
# Source Code Structure
- `IM_Remastered.pde` - this is where the everything works together.
- `Config.pde` - this class defines all the settings for the application, such as total numbers of piano key, note delay.
- `Particle.pde` - this class handles effect of a particle.
- `ParticleSystem.pde` - this class handles the whole particle system, sucjhh as force, directions etc.
- `PianoKey.pde` - this class is a piano key object, it contains its positions, and the pitch number for the sound generate.
- `SoundSynth.pde` - this class handles all the MIDI interaction, such as config the external MIDI synthesizers, generating the midi signal.
- `Utils.pde` - this is the help class, provides utilities functions such as calculate the distance to a point, mapping the MIDI program number to a string.