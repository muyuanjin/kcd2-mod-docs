import glob
import logging
from xml.etree import ElementTree

NAMESPACE = "http://www.w3.org/2001/XMLSchema"


def collect_item_names(filenames):
    result = []
    for filename in filenames:
        logging.info("reading {}".format(filename))
        xml = ElementTree.parse(filename)
        item_nodes = xml.findall("./ItemClasses/*")
        for item in item_nodes:
            name = item.get("Name")
            result.append(name)
    return result


def write_item_names_to_xsd(items, xsd_filename):
    xsd_xml = ElementTree.parse(xsd_filename)
    xsd_items_element = xsd_xml.find("./xs:simpleType[@name='ItemName']/xs:restriction", namespaces={"xs": NAMESPACE})
    xsd_items_element.clear()
    for item in items:
        item_node = xsd_xml.getroot().makeelement("xs:enumeration", {"value": item})
        xsd_items_element.append(item_node)
    logging.info("write XSD {}".format(xsd_filename))
    xsd_xml.write(xsd_filename, encoding="utf-8", xml_declaration=True)


def main():
    filenames = ["item.xml"]
    filenames.extend(glob.glob("item__*.xml"))
    items = collect_item_names(filenames)
    items_xsd_file = "_ItemName.xsd"
    write_item_names_to_xsd(items, items_xsd_file)


if __name__ == "__main__":
    logging.basicConfig(level=logging.INFO, format="%(levelname)s: %(message)s")
    main()
