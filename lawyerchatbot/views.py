import openai
from datetime import timezone
from django.http import JsonResponse
from django.shortcuts import render
from openai import OpenAI

from ConsultMe.settings import OPENAI_API_KEY
from .models import Chat
from django.conf import settings
from django.http import JsonResponse, HttpResponseBadRequest
from django.views.decorators.csrf import csrf_exempt
from transformers import pipeline, AutoModelForCausalLM, AutoTokenizer
# Create your views here.


def chatbot_response(request):
    user_input = request.GET.get('message', '')
    if not user_input:
        return JsonResponse({'error': 'No message provided'}, status=400)
    
    try:
        response = openai.ChatCompletion.create(
            model="gpt-4",
            messages=[
                {"role": "system", "content": "You are a lawyer chatbot."},
                {"role": "user", "content": user_input},
            ],
            api_key=settings.OPENAI_API_KEY  # Ensuring the API key is fetched from settings
        )
        # Checking the correct path to the response content
        return JsonResponse({'response': response['choices'][0]['message']['content']})
    except Exception as e:
        print(f"OpenAI API Error: {str(e)}")  # Log the error for debugging
        return JsonResponse({'error': 'Failed to get response from server.'}, status=500)
    
def chat(request):
    return render(request, 'chatbot/chatbot.html')