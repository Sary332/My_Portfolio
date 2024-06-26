'''
Study Case: Customer Sentiment Analysis on Amazon Product Reviews using APIs

**Introduction:**
Customer sentiment analysis plays a crucial role in understanding customer satisfaction and product performance. In this case study, we aim to analyze the sentiment 
of product reviews on Amazon using Natural Language Processing (NLP) techniques and machine learning algorithms. By determining whether reviews are positive, negative,
or neutral, companies can gain valuable insights into customer opinions and sentiments.

**Objective:**
The primary objective of this study is to develop a sentiment analysis model that can classify Amazon product reviews into positive, negative, or neutral categories. 
This model will be built using NLP techniques and machine learning algorithms, and it will leverage Amazon's Product Advertising API to access the product reviews.

**Methodology:**

** Data Collection**

**Description:**
In the initial phase of developing our portfolio prototype, the first step is to collect data. We aim to gather product reviews from Amazon using their 
Product Advertising API. By leveraging this API, we can access a vast array of product reviews across various categories, ensuring the robustness of our 
sentiment analysis model. It's crucial to select a diverse range of products to train our model effectively and capture a broad spectrum of customer sentiments. 
Collecting a sufficient number of reviews for each product will provide us with a rich dataset to train our sentiment analysis model accurately.
'''
**Code:**

```python
import requests

def fetch_amazon_reviews(product_ids):
    """
    Fetches product reviews from Amazon Product Advertising API.

    Args:
    - product_ids (list): List of product IDs for which reviews are to be fetched.

    Returns:
    - reviews (dict): Dictionary containing product reviews keyed by product IDs.
    """
    api_key = "AMAZON_API_KEY"
    reviews = {}

    for product_id in product_ids:
        endpoint = f"https://api.amazon.com/reviews/{product_id}"
        headers = {
            "x-api-key": api_key
        }
        response = requests.get(endpoint, headers=headers)
        
        # Check if the request was successful
        if response.status_code == 200:
            reviews[product_id] = response.json()
        else:
            print(f"Failed to fetch reviews for product ID: {product_id}")

    return reviews

# Example usage
product_ids = ["PRODUCT_ID_1", "PRODUCT_ID_2", "PRODUCT_ID_3"]
reviews = fetch_amazon_reviews(product_ids)
print(reviews)
```

In the provided code:

- We define a function `fetch_amazon_reviews` to fetch product reviews from Amazon's Product Advertising API.
- The function takes a list of product IDs as input and returns a dictionary containing product reviews keyed by product IDs.
- Inside the function, we iterate over each product ID, construct the API endpoint, and make a GET request with the appropriate headers containing our Amazon API key.
- If the request is successful (status code 200), we add the retrieved reviews to the `reviews` dictionary.

----------------------------------------------------------------------------------------------------------------------------------------------------------------------
'''
**Data Preprocessing**

**Description:**
Once we have collected the product reviews from Amazon, the next step in our portfolio prototype is data preprocessing. This crucial step involves cleaning the 
text data to make it suitable for sentiment analysis. We'll perform several text preprocessing techniques such as tokenization, removal of stop words, stemming, 
and lemmatization to clean the text data effectively. Tokenization breaks down the text into individual words or tokens, while stop words removal eliminates common 
words that do not carry significant meaning. Stemming and lemmatization reduce words to their root forms, reducing dimensionality and ensuring consistency.
After preprocessing, we'll convert the text data into a format suitable for machine learning algorithms, such as numerical vectors. Techniques like TF-IDF or 
word embeddings will be employed to represent the text data in a numerical format, facilitating sentiment analysis.
'''
**Code:**

```python
import nltk
from nltk.tokenize import word_tokenize
from nltk.corpus import stopwords
from nltk.stem import PorterStemmer, WordNetLemmatizer
from sklearn.feature_extraction.text import TfidfVectorizer
import string

# Download NLTK resources if not already downloaded
nltk.download('punkt')
nltk.download('stopwords')
nltk.download('wordnet')

def preprocess_text(text):
    """
    Performs text preprocessing on the input text.

    Args:
    - text (str): Input text to be preprocessed.

    Returns:
    - processed_text (str): Preprocessed text.
    """
    # Tokenization
    tokens = word_tokenize(text)
    
    # Convert tokens to lowercase
    tokens = [token.lower() for token in tokens]
    
    # Remove punctuation
    tokens = [token for token in tokens if token not in string.punctuation]
    
    # Remove stop words
    stop_words = set(stopwords.words('english'))
    tokens = [token for token in tokens if token not in stop_words]
    
    # Initialize stemmer and lemmatizer
    stemmer = PorterStemmer()
    lemmatizer = WordNetLemmatizer()
    
    # Perform stemming and lemmatization
    stemmed_tokens = [stemmer.stem(token) for token in tokens]
    lemmatized_tokens = [lemmatizer.lemmatize(token) for token in stemmed_tokens]
    
    # Join tokens back into a single string
    processed_text = ' '.join(lemmatized_tokens)
    
    return processed_text

def convert_to_numerical_vectors(reviews):
    """
    Converts text data into numerical vectors using TF-IDF.

    Args:
    - reviews (list): List of preprocessed text reviews.

    Returns:
    - numerical_vectors (sparse matrix): TF-IDF numerical vectors representing the text data.
    """
    tfidf_vectorizer = TfidfVectorizer()
    numerical_vectors = tfidf_vectorizer.fit_transform(reviews)
    return numerical_vectors

# Example usage
preprocessed_reviews = [preprocess_text(review) for review in reviews]
numerical_vectors = convert_to_numerical_vectors(preprocessed_reviews)
print(numerical_vectors)
```

In the provided code:

- We define a function `preprocess_text` to perform text preprocessing on the input text.
- Inside the function, we tokenize the text, convert tokens to lowercase, remove punctuation and stop words, and perform stemming and lemmatization.
- We also define a function `convert_to_numerical_vectors` to convert the preprocessed text data into numerical vectors using TF-IDF.

----------------------------------------------------------------------------------------------------------------------------------------------------------------------
'''
**Sentiment Analysis Model**

**Description:**
After collecting and preprocessing the Amazon product review data, the next step in our portfolio prototype is to build a sentiment analysis model. We'll choose 
a suitable machine learning algorithm for sentiment analysis, considering options like Naive Bayes, Support Vector Machines (SVM), or deep learning-based models 
such as Recurrent Neural Networks (RNNs) or Transformer models. The sentiment analysis model will be trained using the preprocessed Amazon product review data. 
Once trained, we'll evaluate the model's performance using standard metrics such as accuracy, precision, recall, and F1-score to assess its effectiveness in 
classifying reviews into positive, negative, or neutral sentiments.
'''
**Code:**

```python
from sklearn.model_selection import train_test_split
from sklearn.metrics import accuracy_score, precision_score, recall_score, f1_score
from sklearn.naive_bayes import MultinomialNB
from sklearn.svm import SVC
from sklearn.feature_extraction.text import TfidfVectorizer

# Split data into train and test sets
X_train, X_test, y_train, y_test = train_test_split(numerical_vectors, labels, test_size=0.2, random_state=42)

# Train sentiment analysis model (example using Naive Bayes)
naive_bayes_model = MultinomialNB()
naive_bayes_model.fit(X_train, y_train)

# Evaluate model performance
y_pred = naive_bayes_model.predict(X_test)
accuracy = accuracy_score(y_test, y_pred)
precision = precision_score(y_test, y_pred, average='weighted')
recall = recall_score(y_test, y_pred, average='weighted')
f1 = f1_score(y_test, y_pred, average='weighted')

# Print evaluation metrics
print("Evaluation Metrics:")
print(f"Accuracy: {accuracy}")
print(f"Precision: {precision}")
print(f"Recall: {recall}")
print(f"F1-score: {f1}")
```

In the provided code:

- We split the preprocessed data into train and test sets using `train_test_split`.
- We train the sentiment analysis model using the Naive Bayes algorithm as an example. You can replace it with other algorithms like SVM.
- We evaluate the model's performance on the test set using metrics such as accuracy, precision, recall, and F1-score.

----------------------------------------------------------------------------------------------------------------------------------------------------------------------
'''
**Integration with Amazon Product Advertising API**

**Description:**
As a crucial part of our portfolio prototype, we'll integrate with Amazon's Product Advertising API to fetch real-time product reviews. This integration will 
allow us to continuously gather new reviews for analysis. We'll develop a script or application that interacts with the API, fetching reviews for specified products 
or categories. Once we retrieve the reviews, we'll implement our trained sentiment analysis model to classify them into positive, negative, or neutral sentiments. 
This classification will provide valuable insights into customer opinions and satisfaction levels. To aid interpretation and decision-making, we'll visualize the 
sentiment analysis results using appropriate visualization techniques, such as histograms, pie charts, or word clouds.
'''
**Code:**
  
```python
import requests
import matplotlib.pyplot as plt

# Function to fetch product reviews from Amazon API
def fetch_amazon_reviews(product_id):
    """
    Fetches product reviews from Amazon Product Advertising API.

    Args:
    - product_id (str): ID of the product for which reviews are to be fetched.

    Returns:
    - reviews (list): List of fetched reviews.
    """
    api_key = "AMAZON_API_KEY"
    endpoint = f"https://api.amazon.com/reviews/{product_id}"
    headers = {
        "x-api-key": api_key
    }
    response = requests.get(endpoint, headers=headers)
    return response.json()

# Function to classify reviews using trained sentiment analysis model
def classify_reviews(reviews, sentiment_model):
    """
    Classifies reviews into positive, negative, or neutral sentiments using a trained sentiment analysis model.

    Args:
    - reviews (list): List of fetched reviews.
    - sentiment_model: Trained sentiment analysis model.

    Returns:
    - sentiment_counts (dict): Dictionary containing counts of positive, negative, and neutral sentiments.
    """
    sentiment_counts = {'Positive': 0, 'Negative': 0, 'Neutral': 0}

    for review in reviews:
        text = preprocess_text(review['text'])
        numerical_vector = convert_to_numerical_vector(text)
        sentiment = sentiment_model.predict(numerical_vector)
        sentiment_counts[sentiment] += 1
    
    return sentiment_counts

# Function to visualize sentiment analysis results
def visualize_sentiment(sentiment_counts):
    """
    Visualizes sentiment analysis results using a pie chart.

    Args:
    - sentiment_counts (dict): Dictionary containing counts of positive, negative, and neutral sentiments.
    """
    labels = sentiment_counts.keys()
    sizes = sentiment_counts.values()
    colors = ['gold', 'lightcoral', 'lightskyblue']
    explode = (0.1, 0, 0)  # explode 1st slice

    plt.pie(sizes, explode=explode, labels=labels, colors=colors, autopct='%1.1f%%', shadow=True, startangle=140)
    plt.axis('equal')
    plt.title('Sentiment Analysis Results')
    plt.show()

# Example usage
product_id = "PRODUCT_ID_HERE"
reviews = fetch_amazon_reviews(product_id)
sentiment_counts = classify_reviews(reviews, sentiment_model)
visualize_sentiment(sentiment_counts)
```

In the provided code:

- We define a function `fetch_amazon_reviews` to fetch product reviews from Amazon's Product Advertising API.
- We define a function `classify_reviews` to classify the fetched reviews into positive, negative, or neutral sentiments using our trained sentiment analysis model.
- We define a function `visualize_sentiment` to visualize the sentiment analysis results using a pie chart.

----------------------------------------------------------------------------------------------------------------------------------------------------------------------
'''
After completing the processes of data collection, preprocessing, sentiment analysis model development, and integration with the Amazon Product Advertising API, 
the final step is to implement the entire pipeline. This implementation involves bringing together all the components and executing the workflow to fetch real-time 
product reviews from Amazon, preprocess them, classify their sentiments, and visualize the results. Below is the code implementation of the entire pipeline:
'''
```python
import requests
import nltk
from nltk.tokenize import word_tokenize
from nltk.corpus import stopwords
from nltk.stem import PorterStemmer, WordNetLemmatizer
from sklearn.feature_extraction.text import TfidfVectorizer
from sklearn.model_selection import train_test_split
from sklearn.metrics import accuracy_score, precision_score, recall_score, f1_score
from sklearn.naive_bayes import MultinomialNB
import matplotlib.pyplot as plt
import string

# Download NLTK resources if not already downloaded
nltk.download('punkt')
nltk.download('stopwords')
nltk.download('wordnet')

# Function to fetch product reviews from Amazon API
def fetch_amazon_reviews(product_id):
    """
    Fetches product reviews from Amazon Product Advertising API.

    Args:
    - product_id (str): ID of the product for which reviews are to be fetched.

    Returns:
    - reviews (list): List of fetched reviews.
    """
    api_key = "AMAZON_API_KEY"
    endpoint = f"https://api.amazon.com/reviews/{product_id}"
    headers = {
        "x-api-key": api_key
    }
    response = requests.get(endpoint, headers=headers)
    return response.json()

# Function to preprocess text data
def preprocess_text(text):
    """
    Performs text preprocessing on the input text.

    Args:
    - text (str): Input text to be preprocessed.

    Returns:
    - processed_text (str): Preprocessed text.
    """
    # Tokenization
    tokens = word_tokenize(text)
    
    # Convert tokens to lowercase
    tokens = [token.lower() for token in tokens]
    
    # Remove punctuation
    tokens = [token for token in tokens if token not in string.punctuation]
    
    # Remove stop words
    stop_words = set(stopwords.words('english'))
    tokens = [token for token in tokens if token not in stop_words]
    
    # Initialize stemmer and lemmatizer
    stemmer = PorterStemmer()
    lemmatizer = WordNetLemmatizer()
    
    # Perform stemming and lemmatization
    stemmed_tokens = [stemmer.stem(token) for token in tokens]
    lemmatized_tokens = [lemmatizer.lemmatize(token) for token in stemmed_tokens]
    
    # Join tokens back into a single string
    processed_text = ' '.join(lemmatized_tokens)
    
    return processed_text

# Function to convert text data into numerical vectors using TF-IDF
def convert_to_numerical_vectors(reviews):
    """
    Converts text data into numerical vectors using TF-IDF.

    Args:
    - reviews (list): List of preprocessed text reviews.

    Returns:
    - numerical_vectors (sparse matrix): TF-IDF numerical vectors representing the text data.
    """
    tfidf_vectorizer = TfidfVectorizer()
    numerical_vectors = tfidf_vectorizer.fit_transform(reviews)
    return numerical_vectors

# Function to train sentiment analysis model
def train_sentiment_model(X_train, y_train):
    """
    Trains a sentiment analysis model using the Naive Bayes algorithm.

    Args:
    - X_train (sparse matrix): Training data features.
    - y_train (array-like): Training data labels.

    Returns:
    - sentiment_model: Trained sentiment analysis model.
    """
    naive_bayes_model = MultinomialNB()
    naive_bayes_model.fit(X_train, y_train)
    return naive_bayes_model

# Function to classify reviews using trained sentiment analysis model
def classify_reviews(reviews, sentiment_model):
    """
    Classifies reviews into positive, negative, or neutral sentiments using a trained sentiment analysis model.

    Args:
    - reviews (list): List of fetched reviews.
    - sentiment_model: Trained sentiment analysis model.

    Returns:
    - sentiment_counts (dict): Dictionary containing counts of positive, negative, and neutral sentiments.
    """
    sentiment_counts = {'Positive': 0, 'Negative': 0, 'Neutral': 0}

    for review in reviews:
        text = preprocess_text(review['text'])
        numerical_vector = convert_to_numerical_vectors([text])
        sentiment = sentiment_model.predict(numerical_vector)[0]
        sentiment_counts[sentiment] += 1
    
    return sentiment_counts

# Function to visualize sentiment analysis results
def visualize_sentiment(sentiment_counts):
    """
    Visualizes sentiment analysis results using a pie chart.

    Args:
    - sentiment_counts (dict): Dictionary containing counts of positive, negative, and neutral sentiments.
    """
    labels = sentiment_counts.keys()
    sizes = sentiment_counts.values()
    colors = ['gold', 'lightcoral', 'lightskyblue']
    explode = (0.1, 0, 0)  # explode 1st slice

    plt.pie(sizes, explode=explode, labels=labels, colors=colors, autopct='%1.1f%%', shadow=True, startangle=140)
    plt.axis('equal')
    plt.title('Sentiment Analysis Results')
    plt.show()

# Example usage
product_id = "PRODUCT_ID_HERE"
reviews = fetch_amazon_reviews(product_id)
preprocessed_reviews = [preprocess_text(review['text']) for review in reviews]

# Assuming you have a preprocessed dataset 'X' and corresponding labels 'y' from previous steps
X_train, X_test, y_train, y_test = train_test_split(numerical_vectors, labels, test_size=0.2, random_state=42)
sentiment_model = train_sentiment_model(X_train, y_train)

# Classify fetched reviews using the trained sentiment analysis model
sentiment_counts = classify_reviews(reviews, sentiment_model)

# Visualize sentiment analysis results
visualize_sentiment(sentiment_counts)
```
'''
This code integrates all the processes from data collection using Amazon's Product Advertising API, preprocessing the fetched reviews, training a sentiment analysis 
model, classifying the reviews, and visualizing the sentiment analysis results. Replace `"YOUR_AMAZON_API_KEY"` with your actual Amazon API key and `"PRODUCT_ID_HERE"` 
with the desired product ID for which you want to analyze reviews. Additionally, ensure you have preprocessed numerical vectors (`numerical_vectors`) and corresponding 
labels (`labels`) for training the sentiment analysis model.
'''
