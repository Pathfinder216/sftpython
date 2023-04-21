"""SFTP functionality"""
try:
    import importlib.metadata

    __version__ = importlib.metadata.version(__package__ or __name__)
except ImportError:
    from pkg_resources import get_distribution

    __version__ = get_distribution(__package__ or __name__).version


class Connection:  # pylint: disable=too-few-public-methods
    """Connection"""
