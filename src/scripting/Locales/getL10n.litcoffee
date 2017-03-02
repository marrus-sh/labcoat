Use Object.defineProperty because this shouldn't be enumerable:

    Object.defineProperty Locales, "getL10n",
        value: (locale) -> Locales[locale]
