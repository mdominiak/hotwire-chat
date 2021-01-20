const DATA_ATTR_NAME = 'data-current-user-id'

export const currentUserId = () => {
  return (
    document
      .querySelector(`[${DATA_ATTR_NAME}]`)
      ?.getAttribute(DATA_ATTR_NAME) || null
  )
}
