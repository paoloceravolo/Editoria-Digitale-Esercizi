import yaml
import json

def load_yaml(file_path):
    """Carica il file YAML."""
    with open(file_path, "r", encoding="utf-8") as file:
        return yaml.safe_load(file)

def convert_to_onix(data):
    """Converte i metadati YAML nel formato ONIX."""
    onix = {
        "Product": {
            "Title": data["distribuzione"]["onix"]["title"],
            "Contributor": {
                "PrimaryAuthor": data["distribuzione"]["onix"]["contributor"]["primary_author"],
                "OtherAuthors": data["distribuzione"]["onix"]["contributor"]["other_authors"],
            },
            "Publisher": data["distribuzione"]["onix"]["publisher"],
            "PublicationDate": data["distribuzione"]["onix"]["publication_date"],
            "ISBN": data["distribuzione"]["onix"]["isbn"],
            "Audience": data["distribuzione"]["onix"]["audience"],
            "Format": data["distribuzione"]["onix"]["format"],
            "Price": data["distribuzione"]["onix"]["price"],
        }
    }
    return onix

def convert_to_schema_org(data):
    """Converte i metadati YAML nel formato Schema.org."""
    schema_org = {
        "@context": "https://schema.org",
        "@type": "Book",
        "name": data["distribuzione"]["schema_org"]["name"],
        "author": [
            {
                "@type": "Person",
                "name": author["name"]
            } for author in data["distribuzione"]["schema_org"]["author"]
        ],
        "datePublished": data["distribuzione"]["schema_org"]["datePublished"],
        "publisher": {
            "@type": "Organization",
            "name": data["distribuzione"]["schema_org"]["publisher"]["name"]
        },
        "isbn": data["distribuzione"]["schema_org"]["isbn"],
        "genre": data["distribuzione"]["schema_org"]["genre"],
        "language": data["distribuzione"]["schema_org"]["language"],
        "inLanguage": data["distribuzione"]["schema_org"]["inLanguage"],
        "format": data["distribuzione"]["schema_org"]["format"],
    }
    return schema_org

def save_to_file(data, file_path, format="json"):
    """Salva i dati in un file (ONIX o Schema.org)."""
    with open(file_path, "w", encoding="utf-8") as file:
        if format == "json":
            json.dump(data, file, indent=4, ensure_ascii=False)
        else:
            file.write(str(data))  # Default string format
    print(f"Salvato in: {file_path}")

# Esempio di utilizzo
yaml_file = "metadati.yaml"  # Percorso al file YAML
data = load_yaml(yaml_file)

# Trasformazione ONIX
onix_data = convert_to_onix(data)
save_to_file(onix_data, "output_onix.json", format="json")

# Trasformazione Schema.org
schema_org_data = convert_to_schema_org(data)
save_to_file(schema_org_data, "output_schema_org.json", format="json")