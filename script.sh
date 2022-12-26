#!/usr/bin/env bash
###############################
# Notify start sessions ssh   #
###############################
#Credenciales del bot
KEY="your-bot"
USERID="your-id-chat-telegram"
URL="https://api.telegram.org/bot${KEY}/sendMessage"
DATE="$(date "+%d %b %Y %H:%M")"
CURL=/usr/bin/curl
LOG="/var/log/telegram.log"
PUBLIC_IP=$(curl -s -X GET https://checkip.amazonaws.com)
REGISTRO="[${DATE} pam_type ${PAM_TYPE}: pam_user ${PAM_USER} from ${PAM_RHOST}"
if [ ! -f ${LOG} ]; then
    touch ${LOG}
    chown root.adm ${LOG}
    chmod 0640 ${LOG}
fi
echo ${REGISTRO} >> ${LOG}
if  [ -n "$PAM_RHOST" ]; then
   MESSAGE="%F0%9F%92%BB ${PAM_TYPE} SSH desde ${PAM_RHOST} en Host %F0%9F%90%B3 con usuario ${PAM_USER} %F0%9F%91%A8%F0%9F%8F%BB%E2%80%8D%F0%9F%92%BB el día ${DATE} %F0%9F%93%86, desde la IP pública $PUBLIC_IP %F0%9F%8C%90"	
   $CURL -s -d "chat_id=$USERID&disable_web_page_preview=1&text=$MESSAGE" $URL > /tmp/curl
fi
exit 0
