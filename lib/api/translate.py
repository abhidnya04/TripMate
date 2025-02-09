import googletrans
import speech_recognition
import gtts
import playsound

#print (googletrans.LANGUAGES)

input_lang = "en"
output_lang = "fr"
recognizer = speech_recognition.Recognizer()
try:
    with speech_recognition.Microphone() as source:
        print("Speak now!")
        voice = recognizer.listen(source)
        text = recognizer.recognize_google(voice,language=input_lang)
        print (text)

    translator = googletrans.Translator()
    translation = translator.translate(text,dest=output_lang)
    print(translation.text)    
    converted_audio = gtts.gTTS(translation.text, lang=output_lang)
    converted_audio.save("hello.mp3")
    playsound.playsound("hello.mp3")




except speech_recognition.UnknownValueError:
    print("Sorry, I could not understand the audio.")
except Exception as e:
    print(f"An error occurred: {e}")        