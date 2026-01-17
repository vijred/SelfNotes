ChromaDB
====
In the AI / LangChain / agent / chatbot context, a Chroma database (ChromaDB) is a vector database used to store, index, and retrieve embeddings so that language models can perform semantic search and retrieval-augmented generation (RAG).

What Chroma Actually Stores:
* Embeddings (vectors)
* Original text (documents, chunks)
* Metadata (source, timestamp, document ID, permissions)

Why Chroma Is Popular with LangChain:
Lightweight (runs locally or embedded)
Simple to use with LangChain
Open-source
Ideal for prototypes, POCs, and local agents
LangChain has first-class integration with Chroma.

Sample code - 
```
__import__('pysqlite3')
import sys
sys.modules['sqlite3'] = sys.modules.pop('pysqlite3')

from langchain.tools.retriever import create_retriever_tool
from langchain_chroma import Chroma 
from langchain_community.document_loaders import PyPDFLoader
from langchain_openai import OpenAIEmbeddings
from langchain_text_splitters import RecursiveCharacterTextSplitter

# Load, chunk and index the contents of the product featuers document.
loader=PyPDFLoader("./data/Laptop product descriptions.pdf")
docs = loader.load()

text_splitter = RecursiveCharacterTextSplitter(chunk_size=1024, chunk_overlap=256)
splits = text_splitter.split_documents(docs)

#Create a vector store with Chroma
prod_feature_store = Chroma.from_documents(
    documents=splits, 
    embedding=embedding
)

get_product_features = create_retriever_tool(
    prod_feature_store.as_retriever(search_kwargs={"k": 1}),
    name="Get_Product_Features",
    description="""
    This store contains details about Laptops. It lists the available laptops
    and their features including CPU, memory, storage, design and advantages
    """
)

#Test the product feature store
#print(prod_feature_store.as_retriever().invoke("Tell me about the AlphaBook Pro") )
```
