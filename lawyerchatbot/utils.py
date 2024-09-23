# import openai
# from django.conf import settings

# openai.api_key=settings.APIKEY

# def send_code_to_api(law):
#     res=openai.ChatCompletion.create(
#         model="gpt-3.5-turbo",
#         messages=[
#             {"role": "system","content":"You are my personal legal assistant"},
#             {"role": "system","content":f"What do you know about UK LAW {law}"},
#         ],
#     )
    
#     return res["choices"][0]["messages"]["content"]